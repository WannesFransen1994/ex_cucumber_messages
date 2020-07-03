defmodule ExCucumberMessageTest do
  use ExUnit.Case
  doctest ExCucumberMessage

  test "greets the world" do
    assert ExCucumberMessage.hello() == :world
  end
end
