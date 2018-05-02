defmodule ExplorerWeb.AddressView do
  use ExplorerWeb, :view

  alias Explorer.Chain.Address

  @dialyzer :no_match

  def balance(%Address{balance: nil}), do: ""

  def balance(%Address{balance: balance}) do
    format_wei_value(balance, :ether, fractional_digits: 18)
  end
end
