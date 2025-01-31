defmodule CrudAppWeb.BookController do
  use CrudAppWeb, :controller
  alias CrudApp.Library

  # Criar livro
  def create(conn, %{"book" => book_params}) do
    case Library.create_book(book_params) do
      {:ok, book} -> json(conn, book)
      {:error, changeset} -> conn |> put_status(:unprocessable_entity) |> json(changeset)
    end
  end

  # Listar todos os livros
  def index(conn, _params) do
    books = Library.list_books()
    json(conn, books)
  end

  # Buscar livro pelo ISBN
  def show_by_isbn(conn, %{"isbn" => isbn}) do
    case Library.get_book_by_isbn(isbn) do
      nil -> send_resp(conn, :not_found, "Book not found")
      book -> json(conn, book)
    end
  end

  # Listar livros por autor
  def list_by_author(conn, %{"author" => author}) do
    books = Library.list_books_by_author(author)
    json(conn, books)
  end

  # Atualizar o ano do livro
  def update_year(conn, %{"id" => id, "year" => year}) do
    book = Library.get_book!(id)

    case Library.update_book_year(book, year) do
      {:ok, book} -> json(conn, book)
      {:error, changeset} -> conn |> put_status(:unprocessable_entity) |> json(changeset)
    end
  end

  # Buscar livro por ID
  def show(conn, %{"id" => id}) do
    book = Library.get_book!(id)
    json(conn, book)
  end

  # Atualizar livro (geral)
  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Library.get_book!(id)

    case Library.update_book(book, book_params) do
      {:ok, book} -> json(conn, book)
      {:error, changeset} -> conn |> put_status(:unprocessable_entity) |> json(changeset)
    end
  end

  # Deletar livro
  def delete(conn, %{"id" => id}) do
    book = Library.get_book!(id)
    {:ok, _book} = Library.delete_book(book)
    send_resp(conn, :no_content, "")
  end
end
