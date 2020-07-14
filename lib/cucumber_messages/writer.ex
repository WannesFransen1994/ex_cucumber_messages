defmodule ExCucumberMessages.Writer do
  defp unstruct(%{__struct__: _} = map) do
    map
    |> Map.from_struct()
    |> unstruct()
    |> case do
      {:ok, v} -> v
      {:replace, k, v} -> %{k => unstruct(v)}
      data -> data
    end
  end

  defp unstruct(%{} = map) do
    Enum.map(map, fn {k, v} ->
      new_v =
        case unstruct(v) do
          {:ok, v} -> v
          {:replace, k, v} -> %{k => unstruct(v)}
          data -> data
        end

      {k, new_v}
    end)
    |> Enum.into(%{})
  end

  defp unstruct(list) when is_list(list) do
    Enum.map(list, fn el ->
      case unstruct(el) do
        {:ok, v} -> v
        {:replace, k, v} -> %{k => unstruct(v)}
        data -> data
      end
    end)
  end

  defp unstruct({key, value}), do: {:replace, key, value}
  defp unstruct(just_a_value), do: {:ok, just_a_value}

  def envelopes_to_ndjson!(list_of_envelopes) when is_list(list_of_envelopes) do
    list_of_envelopes
    |> Enum.map(&(&1 |> unstruct |> Jason.encode!()))
    |> Enum.join("\n")
  end
end
