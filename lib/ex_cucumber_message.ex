defmodule ExCucumberMessages do
  @moduledoc """
  Documentation for `ExCucumberMessages`.
  """

  @doc """
  Convert a list of envelopes to the passed format

  ## Examples

      iex> ExCucumberMessages.convert_envelopes_to(envelopes, :ndjson)
      TODO: write decent documentation

  """
  def convert_envelopes_to(envelopes, :ndjson) do
    Enum.map(envelopes, &ExCucumberMessages.Writer.envelope_to_ndjson!/1)
    |> Enum.map(&Jason.encode!(&1))
    |> Enum.join("\n")
    |> case do
      "" -> ""
      result -> result <> "\n"
    end
  end

  # def convert_envelopes_to(envelopes, :binary) do
  # end
end
