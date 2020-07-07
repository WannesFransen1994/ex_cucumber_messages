defmodule ExCucumberMessagesTest do
  use ExUnit.Case
  doctest ExCucumberMessages

  test "greets the world" do
    assert ExCucumberMessages.hello() == :world
  end
end
