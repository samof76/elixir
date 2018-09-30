defmodule DatabaseServer do
    # start/0 is the fuction of the Databaserver
    # that starts the server process by spawning
    # loop/0 and returns its PID.
    def start do
        spawn(&loop/0)
    end

    # loop/0 is the fuction of the DatabaseServer
    # that that basically waits to `receive` messages
    # from the client inthe format `{:run_query, caller, query_def}
    # sends the back the results computed by the run_query
    # back to `caller`, and the loop/0 calls its itself
    # waiting for the next query
    defp loop do
        receive do
            {:run_query, caller, query_def} ->
                processor_pid = spawn(&run_query_async/0)
                send(processor_pid, {:process, caller, query_def})
                IO.puts(query_def)
            # code
        end
        
        loop() # Infinite, hence server
    end

    # run_query/1 is a helper function that
    # gets called by the server for execute the query
    defp run_query(query_def) do
        Process.sleep(2000)
        "result: #{query_def}"
    end

    defp run_query_async do
        receive do
            {:process, caller, query_def} ->
                send(caller, {:query_result, run_query(query_def)})
            # code
        end
    end


    # run_async/2 is the interface function to the client
    # that actually sends the query to the server process
    # created by calling start/0, this the server process'
    # PID the `query_def` string.
    def run_async(server_pid, query_def) do
        send(server_pid, {:run_query, self(), query_def})
    end

    # get_result/0 is a helper function to receive messages
    # sent by the server from the client's mailbox.
    def get_result() do
        receive do
            {:query_result, value} -> value
        after
            5000 -> {:error, :timeout}
            # code
        end
    end
end