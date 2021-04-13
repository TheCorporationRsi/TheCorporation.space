from corporation import create_app
import bot


app = create_app()

if __name__ == "__main__":
    app.run(debug=False)

