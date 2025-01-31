defmodule CrudApp.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title, :author, :year, :isbn, :inserted_at, :updated_at]}

  schema "books" do
    field :title, :string
    field :author, :string
    field :year, :integer
    field :isbn, :string

    timestamps()
  end

  # Função para validar e criar o livro
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :year, :isbn])
    |> validate_required([:title, :author])  # Validação para título e autor
    |> validate_length(:isbn, is: 13)         # ISBN com 13 caracteres
    |> unique_constraint(:isbn)              # Garantir que o ISBN é único
  end
end
