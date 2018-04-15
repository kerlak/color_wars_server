defmodule ColorWarsWeb.Colors do
  alias ColorWarsWeb.Colors

  def start_link do
    Agent.start_link(fn -> %{color_1: 0, color_2: 0} end, name: __MODULE__)
  end

  def get do
    Agent.get(__MODULE__, fn(colors) -> colors end)
  end

  def increase(color_to_increase) do
    Agent.update(__MODULE__, fn(colors) -> increase(colors, color_to_increase) end)
  end

  def increase(colors, :color_1) do
    %{colors | color_1: colors.color_1 + 1}
  end

  def increase(colors, :color_2) do
    %{colors | color_2: colors.color_2 + 1}
  end

end
