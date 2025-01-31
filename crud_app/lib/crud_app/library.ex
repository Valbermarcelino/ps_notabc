defmodule CrudApp.Library do
  import Ecto.Query, warn: false
  alias CrudApp.Repo
  alias CrudApp.Library.Book

  # Criar livro com validações
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  # Listar todos os livros
  def list_books do
    Repo.all(Book)
  end

  # Buscar livro pelo ISBN
  def get_book_by_isbn(isbn) do
    Repo.get_by(Book, isbn: isbn)
  end

  # Listar livros por autor
  def list_books_by_author(author) do
    query = from b in Book, where: b.author == ^author
    Repo.all(query)
  end

  # Buscar livro por ID
  def get_book!(id), do: Repo.get!(Book, id)

  # Atualizar o ano do livro
  def update_book_year(%Book{} = book, year) do
    book
    |> Ecto.Changeset.change(year: year)
    |> Repo.update()
  end

  # Atualizar o livro (qualquer campo)
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  # Deletar livro
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end
end
