 # Этап 1: Сборка исполняемого файла Go
FROM golang:1.18 AS builder

# Установка рабочей директории внутри контейнера
WORKDIR /app

# Копирование go.mod и go.sum для управления зависимостями
COPY go.mod go.sum ./
RUN go mod download

# Копирование исходного кода приложения в контейнер
COPY . .

# Компиляция приложения. При необходимости замените 'main.go' на путь к вашему файлу.
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Этап 2: Создание минимального образа для запуска
FROM alpine:latest  

RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Копирование исполняемого файла из первого этапа в минимальный образ
COPY --from=builder /app/main .

# Открытие порта, который использует ваше приложение
EXPOSE 8080

# Запуск приложения
CMD ["./main"]
