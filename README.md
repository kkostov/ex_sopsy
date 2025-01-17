# ExSopsy ![Hex.pm Version](https://img.shields.io/hexpm/v/ex_sopsy) [![Hex Docs](https://img.shields.io/badge/docs-hexpm-blue.svg)](https://hexdocs.pm/ex_sopsy/) [![CI](https://github.com/kkostov/ex_sopsy/actions/workflows/ci.yml/badge.svg)](https://github.com/kkostov/ex_sopsy/actions/workflows/ci.yml)

Sopsy is a pragmatic wrapper around Mozilla SOPS allowing decryption of secrets at runtime.

The goal of the library is to offer a simple solution for bringing encrypted secrets into your Elixir application, especially suited for self-hosting (VPS) and easy-to-manage environments (e.g. doesn't require a Vault or a managed service)


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

The library is usable from any module in the application.

## Installation

Add `ex_sopsy` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_sopsy, "~> 1.0.1"}
  ]
end
```

## License

Copyright 2025 Konstantin hi@iamkonstantin.eu

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

