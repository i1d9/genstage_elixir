defmodule Gencounter.ProducerConsumer do
    use GenStage

    require Integer

    def start_link do
        GenStage.start_link(__MODULE__, :state, name: __MODULE__)
    end

    @doc """
    Subscribe to the producer
    """
    def init(state) do
        {:producer_consumer, state, subscribe_to: [Gencounter.Producer] }
    end


    @doc """
    Receive in coming events using the events variable

    The producer generates a list of numbers that can be consumed the producer consumer

    it returns a tuple the second item is used by the next consumer down stream
    """
    def handle_events(events, _from, state) do
        numbers =
            events
            |> Enum.filter(&Integer.is_even/1)

        {:noreply, numbers, state}
    end
end