defmodule Centrix.Devices do
  @moduledoc """
  The Devices context.
  """

  import Ecto.Query, warn: false
  alias Centrix.Repo

  alias Centrix.Devices.{Consumption, Sensor, Device}

  def list_devices(preloads \\ []) do
    Device
    |> preload(^preloads)
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

  alias Centrix.Devices.Category

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
end
