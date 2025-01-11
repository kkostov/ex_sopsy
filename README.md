# ExSopsy

Sopsy is a pragramtic wrapper around Mozila SOPS allowing decryption of secrets at runtime.

The goal of the library is to offer a simple solution for bringing encrypted secrets into your Elixir application.


## Requirements

* [Mozilla SOPS](https://github.com/getsops/sops) CLI must be installed on the system and available in the PATH.
* The Elixir application must have read access to the SOPS encrypted file.
* Use environment variables or `.sops.yaml` configuration file to configure the sops binary as needed.

## Usage

You can call `ExSopsy.load_secrets` passing a path to a SOPS encrypted file and the format of the file.
If decryption is successful, the function returns a tuple `{:ok, Map.t}` with the decrypted secret keys.

```elixir
# config/runtime.exs
if config_env() == :prod do
  case ExSopsy.load_secrets("priv/secrets.enc.json", :json) do
    {:ok, secrets} ->
      config :my_app, MyApp.Repo,
        username: secrets["db_user"],
        password: secrets["db_password"]

      config :my_app, MyAppWeb.Endpoint,
        secret_key_base: secrets["secret_key_base"]

    {:error, reason} ->
      raise "Failed to load secrets: #{inspect(reason)}"
  end
end

```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_sopsy` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_sopsy, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ex_sopsy>.
