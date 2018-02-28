defmodule Explorer.Receipt do
  @moduledoc "Captures a Web3 Transaction Receipt."

  use Explorer.Schema

  alias Explorer.Transaction
  alias Explorer.Log
  alias Explorer.Receipt

  @required_attrs ~w(cumulative_gas_used gas_used status index)a
  @optional_attrs ~w()a

  schema "receipts" do
    has_one(:transaction, Transaction)
    has_many(:logs, Log)
    field(:cumulative_gas_used, :decimal)
    field(:gas_used, :decimal)
    field(:status, :integer)
    field(:index, :integer)
    timestamps()
  end

  def changeset(%Receipt{} = transaction_receipt, attrs \\ %{}) do
    transaction_receipt
    |> cast(attrs, @required_attrs)
    |> cast(attrs, @optional_attrs)
    |> cast_assoc(:transaction)
    |> cast_assoc(:logs)
    |> validate_required(@required_attrs)
  end

  def null, do: %Receipt{}
end
