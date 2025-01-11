defmodule ExSopsyTest do
  use ExUnit.Case
  doctest ExSopsy

  test "decrypts a json file" do
    {:ok, result} = ExSopsy.load_secrets("./test/files/example.enc.json", :json)
    IO.inspect(result, label: "result")
    assert result["hello"] == "Handling Secrets should not be complicated"
    assert result["example_number"] == 1234.56789
    assert result["example_booleans"] == [true, false]
    assert result["example_array"] == ["example_value1", "example_value2"]
    assert result["example_key"] == "example_value"
  end
end
