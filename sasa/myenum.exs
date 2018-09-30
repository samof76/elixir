defmodule MyEnum do
    def all?([], _) do
        true
    end
    def all?([h|t], f) do
        truthy(t,f,f.(h))
    end

    defp truthy([],_,true) do
        true
    end

    defp truthy([],_,false) do
        false
    end
    
    defp truthy([h|t],f,true) do
        truthy(t,f,f.(h))
    end

    defp truthy(_,_,false) do
        false
    end

    def each([], _) do
        :ok
    end    
    def each([h|t], f) do
        f.(h)
        each(t,f)
    end

    def filter(l,f) do
        filterp(l,[],f)
    end

    defp filterp([],l,_) do
        :lists.reverse(l)
    end

    defp filterp([h|t],l,f) do
        cond do
            f.(h) -> filterp(t,[h|l],f)
            true  -> filterp(t,l,f)
        end
    end
end
