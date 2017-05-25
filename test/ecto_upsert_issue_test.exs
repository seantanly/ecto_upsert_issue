defmodule EctoUpsertIssueTest do
  use ExUnit.Case
  doctest EctoUpsertIssue

  alias EctoUpsertIssue.Repo
  alias EctoUpsertIssue.Tag

  test "upsert on conflict returns the same record" do
    Repo.delete_all(Tag)

    tag = Tag.find_or_create!("interesting")
    tag2 = Tag.find_or_create!("interesting")
    db_tags = Repo.all(Tag)

    assert length(db_tags) == 1
    db_tag = List.first(db_tags)

    assert db_tag.id == tag.id
    assert tag2.id == tag.id
  end
end
