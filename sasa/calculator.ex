defmodule Calculator do
    def start do
        spawn(fn -> loop(0) end)
    end

    defp loop(current_value) do
        new_value =
            receive do
            {:value, caller} ->
                send(caller, {:response, current_value})
                current_value
            {:add, value} ->
                current_value + value
            {:sub, value} ->
                current_value - value
            {:mul, value} ->
                current_value * value
            {:div, value} ->
                current_value / value
            
            invalid_request ->
                IO.puts("invalid request #{inspect invalid_request}")
                current_value
            end
        loop(new_value)
    end

    def value(server_pid) do
        send(server_pid, {:value, self()})
        receive do
            {:response, value} ->
                IO.puts(value)
        end
    end

    def add(server_pid, value) do
        send(server_pid, {:add, value})
    end

    def sub(server_pid, value) do
        send(server_pid, {:sub, value})
    end

    def mul(server_pid, value) do
        send(server_pid, {:mul, value})
    end

    def div(server_pid, value) do
        send(server_pid, {:div, value})
    end
end