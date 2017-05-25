defmodule EctoUpsertIssue.Tag do
  use Ecto.Schema
  alias EctoUpsertIssue.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime, usec: false]
  schema "tags" do
    field :name, :string
    timestamps()
  end

  def find_or_create!(name) do
    name = name |> String.downcase |> String.trim
    Repo.insert!(
      %__MODULE__{name: name},
      on_conflict: [set: [name: name]],
      conflict_target: :name
    )
  end
end
