defmodule CentrixWeb.Router do
  use CentrixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Centrix.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated, error_handler: Centrix.ErrorHandler, module: Centrix.Guardian
  end

  pipeline :ensure_not_auth do
    plug Guardian.Plug.EnsureNotAuthenticated, error_handler: Centrix.ErrorHandler, module: Centrix.Guardian
  end

  scope "/api/auth", CentrixWeb.Api.V1 do
    pipe_through [:api, :ensure_not_auth]

    post "/register", SessionController, :create
    post "/login", SessionController, :login
  end

  scope "/api/v1", CentrixWeb.Api.V1 do
    pipe_through [:api, :auth, :ensure_auth]

    resources "/categories", CategoryController, only: [:index, :create] do
      resources "/devices", DeviceController, only: [:index, :create] do
        resources "/sensors", SensorController, only: [:create, :index]
      end
    end

    resources "/consumptions", ConsumptionController, only: [:index]

    get "/sensors/:sensor_id/turn_on", SensorController, :turn_on
    get "/sensors/:sensor_id/turn_off", SensorController, :turn_off
  end


  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: CentrixWeb.Telemetry
    end
  end
end
