defmodule EctoUpsertIssueTest do
  use ExUnit.Case
  doctest EctoUpsertIssue

  alias EctoUpsertIssue.Repo
  alias EctoUpsertIssue.Tag

  test "upsert on conflict returns the same struct.id" do
    Repo.delete_all(Tag)

    name = "unique"
    tag = Repo.insert!(%Tag{name: name}, on_conflict: [set: [name: name]], conflict_target: :name)
    tag2 = Repo.insert!(%Tag{name: name}, on_conflict: [set: [name: name]], conflict_target: :name)
    db_tags = Repo.all(Tag)

    assert length(db_tags) == 1
    db_tag = List.first(db_tags)

    assert db_tag.id == tag.id
    assert tag2.id == tag.id
  end


  test "upsert id should be nil when on_conflict: :nothing" do
    Repo.delete_all(Tag)

    name = "unique"
    tag = Repo.insert!(%Tag{name: name}, on_conflict: :nothing)
    tag2 = Repo.insert!(%Tag{name: name}, on_conflict: :nothing)

    assert tag2.id == nil
  end
end
