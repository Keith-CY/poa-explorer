defmodule ExplorerWeb.BlockView do
  use ExplorerWeb, :view

  alias Explorer.Chain.{Block, Wei}

  @dialyzer :no_match

  # Functions

  def age(%Block{timestamp: timestamp}) do
    Timex.from_now(timestamp)
  end

  def formatted_timestamp(%Block{timestamp: timestamp}) do
    Timex.format!(timestamp, "%b-%d-%Y %H:%M:%S %p %Z", :strftime)
  end

  def average_gas_price(%Block{transactions: transactions}) do
    average =
      transactions
      |> Enum.map(&Decimal.to_float(Wei.to(&1.gas_price, :gwei)))
      |> Math.Enum.mean()
      |> Kernel.||(0)
      |> Cldr.Number.to_string!()

    unit_text = gettext("Gwei")

    "#{average} #{unit_text}"
  end
end
