defmodule EKatale.Utils do
    
    def atomize_map_keys(map) do
        map
        |> Enum.map(fn {k,v} -> {String.to_atom(k), v} end)
        |> Enum.into(%{})
    end

    def drop_meta_data(data) when is_list(data) do
        data
        |> Enum.map(fn x -> 
            x
            |> Map.from_struct()
            |> Map.drop([:__meta__])
        end)    
    end

    def drop_meta_data(data) do
        data
        |> Map.from_struct()
        |> Map.drop([:__meta__])
    end  

end