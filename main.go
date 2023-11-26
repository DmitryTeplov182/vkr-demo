package main

import (
    "fmt"
    "net/http"
    "os"
)

func handler(w http.ResponseWriter, r *http.Request) {
    podName := os.Getenv("POD_NAME")
    nodeName := os.Getenv("NODE_NAME")

    fmt.Fprintf(w, "<h1>ВКР Теплова Д.Ю.</h1>")
    fmt.Fprintf(w, "<h2>Версия 2</h1>")
    fmt.Fprintf(w, "<p>Имя контейнера: %s</p>", podName)
    fmt.Fprintf(w, "<p>Имя сервера: %s</p>", nodeName)
}

func main() {
    http.HandleFunc("/", handler)
    fmt.Println("Сервер запущен на http://localhost:8080")
    http.ListenAndServe(":8080", nil)
}
