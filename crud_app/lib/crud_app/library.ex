defmodule CrudApp.Library do
  alias CrudApp.Repo
  alias CrudApp.Library.Book

  # Criar um livro
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  # Listar todos os livros
  def list_books do
    Repo.all(Book)
  end

  # Buscar um livro por ID
  def get_book!(id), do: Repo.get!(Book, id)

  # Atualizar um livro
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  # Deletar um livro
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end
end
