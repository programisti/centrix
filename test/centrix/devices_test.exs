defmodule Centrix.DevicesTest do
  use Centrix.DataCase

  # alias Centrix.Devices

  # describe "devices" do
  #   alias Centrix.Devices.Device
  #
  #   @valid_attrs %{name: "some name"}
  #   @update_attrs %{name: "some updated name"}
  #   @invalid_attrs %{name: nil}
  #
  #   def device_fixture(attrs \\ %{}) do
  #     {:ok, device} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Devices.create_device()
  #
  #     device
  #   end
  #
  #   test "list_devices/0 returns all devices" do
  #     device = device_fixture()
  #     assert Devices.list_devices() == [device]
  #   end
  #
  #   test "get_device!/1 returns the device with given id" do
  #     device = device_fixture()
  #     assert Devices.get_device!(device.id) == device
  #   end
  #
  #   test "create_device/1 with valid data creates a device" do
  #     assert {:ok, %Device{} = device} = Devices.create_device(@valid_attrs)
  #     assert device.name == "some name"
  #   end
  #
  #   test "create_device/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Devices.create_device(@invalid_attrs)
  #   end
  #
  #   test "update_device/2 with valid data updates the device" do
  #     device = device_fixture()
  #     assert {:ok, %Device{} = device} = Devices.update_device(device, @update_attrs)
  #     assert device.name == "some updated name"
  #   end
  #
  #   test "update_device/2 with invalid data returns error changeset" do
  #     device = device_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Devices.update_device(device, @invalid_attrs)
  #     assert device == Devices.get_device!(device.id)
  #   end
  #
  #   test "delete_device/1 deletes the device" do
  #     device = device_fixture()
  #     assert {:ok, %Device{}} = Devices.delete_device(device)
  #     assert_raise Ecto.NoResultsError, fn -> Devices.get_device!(device.id) end
  #   end
  #
  #   test "change_device/1 returns a device changeset" do
  #     device = device_fixture()
  #     assert %Ecto.Changeset{} = Devices.change_device(device)
  #   end
  # end
  #
  # describe "consumptions" do
  #   alias Centrix.Devices.Consumption
  #
  #   @valid_attrs %{watt: 42}
  #   @update_attrs %{watt: 43}
  #   @invalid_attrs %{watt: nil}
  #
  #   def consumption_fixture(attrs \\ %{}) do
  #     {:ok, consumption} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Devices.create_consumption()
  #
  #     consumption
  #   end
  #
  #   test "list_consumptions/0 returns all consumptions" do
  #     consumption = consumption_fixture()
  #     assert Devices.list_consumptions() == [consumption]
  #   end
  #
  #   test "get_consumption!/1 returns the consumption with given id" do
  #     consumption = consumption_fixture()
  #     assert Devices.get_consumption!(consumption.id) == consumption
  #   end
  #
  #   test "create_consumption/1 with valid data creates a consumption" do
  #     assert {:ok, %Consumption{} = consumption} = Devices.create_consumption(@valid_attrs)
  #     assert consumption.watt == 42
  #   end
  #
  #   test "create_consumption/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Devices.create_consumption(@invalid_attrs)
  #   end
  #
  #   test "update_consumption/2 with valid data updates the consumption" do
  #     consumption = consumption_fixture()
  #     assert {:ok, %Consumption{} = consumption} = Devices.update_consumption(consumption, @update_attrs)
  #     assert consumption.watt == 43
  #   end
  #
  #   test "update_consumption/2 with invalid data returns error changeset" do
  #     consumption = consumption_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Devices.update_consumption(consumption, @invalid_attrs)
  #     assert consumption == Devices.get_consumption!(consumption.id)
  #   end
  #
  #   test "delete_consumption/1 deletes the consumption" do
  #     consumption = consumption_fixture()
  #     assert {:ok, %Consumption{}} = Devices.delete_consumption(consumption)
  #     assert_raise Ecto.NoResultsError, fn -> Devices.get_consumption!(consumption.id) end
  #   end
  #
  #   test "change_consumption/1 returns a consumption changeset" do
  #     consumption = consumption_fixture()
  #     assert %Ecto.Changeset{} = Devices.change_consumption(consumption)
  #   end
  # end
  #
  # describe "categories" do
  #   alias Centrix.Devices.Category
  #
  #   @valid_attrs %{name: "some name"}
  #   @update_attrs %{name: "some updated name"}
  #   @invalid_attrs %{name: nil}
  #
  #   def category_fixture(attrs \\ %{}) do
  #     {:ok, category} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Devices.create_category()
  #
  #     category
  #   end
  #
  #   test "list_categories/0 returns all categories" do
  #     category = category_fixture()
  #     assert Devices.list_categories() == [category]
  #   end
  #
  #   test "get_category!/1 returns the category with given id" do
  #     category = category_fixture()
  #     assert Devices.get_category!(category.id) == category
  #   end
  #
  #   test "create_category/1 with valid data creates a category" do
  #     assert {:ok, %Category{} = category} = Devices.create_category(@valid_attrs)
  #     assert category.name == "some name"
  #   end
  #
  #   test "create_category/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Devices.create_category(@invalid_attrs)
  #   end
  #
  #   test "update_category/2 with valid data updates the category" do
  #     category = category_fixture()
  #     assert {:ok, %Category{} = category} = Devices.update_category(category, @update_attrs)
  #     assert category.name == "some updated name"
  #   end
  #
  #   test "update_category/2 with invalid data returns error changeset" do
  #     category = category_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Devices.update_category(category, @invalid_attrs)
  #     assert category == Devices.get_category!(category.id)
  #   end
  #
  #   test "delete_category/1 deletes the category" do
  #     category = category_fixture()
  #     assert {:ok, %Category{}} = Devices.delete_category(category)
  #     assert_raise Ecto.NoResultsError, fn -> Devices.get_category!(category.id) end
  #   end
  #
  #   test "change_category/1 returns a category changeset" do
  #     category = category_fixture()
  #     assert %Ecto.Changeset{} = Devices.change_category(category)
  #   end
  # end
end
