defmodule Centrix.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: Centrix.Repo

  alias Centrix.Accounts.User
  alias Centrix.Devices.{Device, Category, Sensor, Consumption}

  def user_factory do
    %User{
      name: "some name",
      email: sequence(:email, &"email-#{&1}@example.com"),
      encrypted_password: "some encrypted_password"
    }
  end

  def category_factory do
    %Category{
      name: "Kitchen",
      user_id: insert(:user).id
    }
  end

  def device_factory do
    %Device{
      name: "Kitchen thermometer",
      user_id: insert(:user).id,
      category_id: insert(:category).id
    }
  end

  def sensor_factory do
    %Sensor{
      name: "Kitchen thermometer sensor",
      device_id: insert(:device).id
    }
  end

  def consumption_factory do
    %Consumption{
      watt: 35,
      device_id: insert(:device).id
    }
  end
end
