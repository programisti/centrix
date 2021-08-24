defmodule Centrix.Devices do
  @moduledoc """
  The Devices context.
  """

  import Ecto.Query, warn: false
  alias Centrix.Repo

  alias Centrix.Devices.{Consumption, Sensor, Device, Category}

  def list_devices(preloads \\ []) do
    Device
    |> preload(^preloads)
    |> Repo.all()
  end

  def list_category_devices(category_id, preloads \\ []) do
    Device
    |> preload(^preloads)
    |> where(category_id: ^category_id)
    |> Repo.all()
  end

  def list_users_category_devices(user, category_id, preloads \\ []) do
    Device
    |> preload(^preloads)
    |> where(category_id: ^category_id)
    |> where(user_id: ^user.id)
    |> Repo.all()
  end

  def get_device!(id), do: Repo.get!(Device, id)

  def create_device(attrs \\ %{}) do
    %Device{}
    |> Device.changeset(attrs)
    |> Repo.insert()
  end

  def update_device(%Device{} = device, attrs) do
    device
    |> Device.changeset(attrs)
    |> Repo.update()
  end

  def delete_device(%Device{} = device) do
    Repo.delete(device)
  end

  def change_device(%Device{} = device, attrs \\ %{}) do
    Device.changeset(device, attrs)
  end

  def list_consumptions do
    Repo.all(Consumption)
  end

  def list_device_consumption(device_id, %{"start_date" => start_date}) do
    Consumption
    |> where(device_id: ^device_id)
    |> where([c], c.inserted_at >= ^parse_datetime(start_date))
    |> Repo.all()
  end

  def list_device_consumption(device_id, %{"start_date" => start_date, "end_date" => end_date}) do
    if is_valid_datetime?(start_date) && is_valid_datetime?(end_date) do
      Consumption
      |> where(device_id: ^device_id)
      |> where([c], c.inserted_at >= ^parse_datetime(start_date))
      |> where([c], c.inserted_at <= ^parse_datetime(end_date))
      |> Repo.all()
    end
  end

  def list_device_consumption(device_id, _params) do
    Consumption
    |> where(device_id: ^device_id)
    |> Repo.all()
  end

  def is_valid_datetime?(datetime) do
    case DateTime.from_iso8601(datetime) do
      {:ok, _datetime, 0} ->
        true

      _ ->
        raise "Date time is not valid"
        false
    end
  end

  defp parse_datetime(datetime) do
    {:ok, datetime, 0} = DateTime.from_iso8601(datetime)
    datetime
  end

  def list_consumptions_for_device(device_id, days) do
    last_date = DateTime.add(DateTime.utc_now(), days, :days)

    Consumption
    |> where(device_id: ^device_id)
    |> where([i], i.inserted_at >= ^last_date)
    |> Repo.all()
  end

  def get_consumption!(id), do: Repo.get!(Consumption, id)

  def create_consumption(attrs \\ %{}) do
    %Consumption{}
    |> Consumption.changeset(attrs)
    |> Repo.insert()
  end

  def update_consumption(%Consumption{} = consumption, attrs) do
    consumption
    |> Consumption.changeset(attrs)
    |> Repo.update()
  end

  def delete_consumption(%Consumption{} = consumption) do
    Repo.delete(consumption)
  end

  def change_consumption(%Consumption{} = consumption, attrs \\ %{}) do
    Consumption.changeset(consumption, attrs)
  end

  def list_consumption_history(device_id, days \\ 30) do
    device_id
    |> get_device!()
    |> list_consumptions_for_device(days)
  end

  def get_sensor!(id), do: Repo.get!(Sensor, id)

  def update_sensor(%Sensor{} = sensor, attrs) do
    sensor
    |> Sensor.changeset(attrs)
    |> Repo.update()
  end

  def turn_sensor_on(sensor_id) do
    sensor_id
    |> get_sensor!()
    |> update_sensor(%{is_on: true})
  end

  def is_sensor_owner?(user, sensor_id) do
    sensor = get_sensor!(sensor_id)
    device = get_device!(sensor.device_id)
    user.id == device.user_id
  end

  def is_device_owner?(user, device_id) do
    device = get_device!(device_id)
    user.id == device.user_id
  end

  def is_device_owner!(user, device_id) do
    device = get_device!(device_id)

    if user.id == device.user_id do
      :ok
    else
      {:error, "Not a device owner"}
    end
  end

  def turn_sensor_off(sensor_id) do
    sensor_id
    |> get_sensor!()
    |> update_sensor(%{is_on: false})
  end

  def create_sensor(attrs \\ %{}) do
    %Sensor{}
    |> Sensor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories(:devices)
      [%Category{}, ...]

  """
  def list_categories(preloads \\ []) do
    Category
    |> preload(^preloads)
    |> Repo.all()
  end

  def list_user_categories(user, preloads \\ []) do
    Category
    |> where(user_id: ^user.id)
    |> preload(^preloads)
    |> Repo.all()
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  def list_sensors() do
    Repo.all(Sensor)
  end

  def list_sensors_for_device(device_id) do
    Sensor
    |> where(device_id: ^device_id)
    |> Repo.all()
  end
end
