defmodule ExSopsy do
  @moduledoc """
  A library for interacting with Mozilla SOPS to fetch secrets at runtime.
  """

  @doc """
  Decrypts a SOPS-encrypted file and returns the secrets as a map.

  ## Examples
      iex> ExSopsy.load_secrets("./test/files/doc.enc.json", :json)
      {:ok, %{"example_key" => "example_value"}}
  """
  def load_secrets(file_path, :json) do
    case System.cmd("sops", ["-d", file_path], stderr_to_stdout: true) do
      {result, 0} ->
        case JSON.decode(result) do
          {:ok, decoded} -> {:ok, decoded}
          {:error, reason} -> {:error, {:invalid_json, reason}}
        end

      {error_output, _exit_code} ->
        {:error, {:sops_failed, error_output}}
    end
  end
end
