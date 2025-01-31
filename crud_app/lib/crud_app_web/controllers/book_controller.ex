defmodule CrudAppWeb.BookController do
  use CrudAppWeb, :controller
  alias CrudApp.Library

  def index(conn, _params) do
    books = Library.list_books()
    json(conn, books)
  end

  def show(conn, %{"id" => id}) do
    book = Library.get_book!(id)
    json(conn, book)
  end

  def create(conn, %{"book" => book_params}) do
    case Library.create_book(book_params) do
      {:ok, book} -> json(conn, book)
      {:error, changeset} -> conn |> put_status(:unprocessable_entity) |> json(changeset)
    end
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Library.get_book!(id)

    case Library.update_book(book, book_params) do
      {:ok, book} -> json(conn, book)
      {:error, changeset} -> conn |> put_status(:unprocessable_entity) |> json(changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Library.get_book!(id)
    {:ok, _book} = Library.delete_book(book)
    send_resp(conn, :no_content, "")
  end
end
