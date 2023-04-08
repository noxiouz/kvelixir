defmodule KV do
  use GenServer

  @me __MODULE__

  def start(default \\ []) do
    GenServer.start(__MODULE__, default, name: @me)
  end

  def stop do
    GenServer.stop(@me)
  end

  def get(key) do
    GenServer.call(@me, {:get, key})
  end

  def put(key, value) do
    GenServer.cast(@me, {:put, key, value})
  end

  def delete(key) do
    GenServer.cast(@me, {:delete, key})
  end


  # Implementation

  def init(_args) do
    {:ok, %{}}
  end

  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end

  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  def handle_cast({:delete, key}, state) do
    {:noreply, Map.delete(state, key)}
  end
end
