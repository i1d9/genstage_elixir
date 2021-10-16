defmodule Gencounter.Producer do


    use GenStage

    def start_link(init \\ 0) do
        GenStage.start_link(__MODULE__, init, name: __MODULE__)
    end


    @doc """
    Return a tuple with the producer atom tells the program that this is a producer
    """
    def init(counter) do
        {:producer, counter}
    end


    @doc """
    Majority of where the producer will handle 
    The consumer or producer consumer sends the demand

    The demand is a positive integer that corresponds to the number of events that the producer can handle at a given time
    """
    def handle_demand(demand, state) do
        events = Enum.to_list(state..state + demand -1)
        {:noreply, events, (state+demand)}
    end

    
end