# defmodule Messages do
#   use Protox, files: ["/home/wannes/Documents/ex_cucumber_message/messages.proto"]
# end
defmodule Messages do
  use Protobuf,
    from: Path.expand("/home/wannes/Documents/ex_cucumber_message/messages.proto")

  # use_package_names: true,
  # namespace: :"Elixir"
end
