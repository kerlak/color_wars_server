defmodule ColorWarsWeb.ColorWarChannel do
  use ColorWarsWeb, :channel

  alias ColorWarsWeb.Colors

  def join("color_war:lobby", payload, socket) do
    if authorized?(payload) do
      colors = Colors.get
      send(self, {:after_join, colors})
      {:ok, colors, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end


  def handle_info({:after_join, colors}, socket) do
    IO.inspect colors
    IO.puts "sending colors"
    broadcast socket, "colors", colors
    {:noreply, socket}
  end


  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (color_war:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("color_1", _payload, socket) do
    Colors.increase(:color_1)
    colors = Colors.get()
    broadcast socket, "colors", colors
    {:noreply, socket}
  end

  def handle_in("color_2", _payload, socket) do
    Colors.increase(:color_2)
    colors = Colors.get()
    broadcast socket, "colors", colors
    {:noreply, socket}
  end

  def handle_in(_message, _payload, socket) do
    Colors.increase(:color_1)
    colors = Colors.get()
    broadcast socket, "colors", colors
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
