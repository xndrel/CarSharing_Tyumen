using System;
using System.IO; // Добавляем это пространство имен

public static class Logger
{
    private static readonly string logPath = Path.Combine(
        AppDomain.CurrentDomain.BaseDirectory,
        "CarSharingLogs.txt");

    public static void LogEvent(string message)
    {
        try
        {
            File.AppendAllText(logPath, $"{DateTime.Now:yyyy-MM-dd HH:mm:ss} - {message}\n");
        }
        catch (Exception ex)
        {
            // Обработка ошибок записи в лог
            Console.WriteLine($"Ошибка записи в лог: {ex.Message}");
        }
    }

    public static void LogError(Exception ex)
    {
        try
        {
            File.AppendAllText(logPath,
                $"[ERROR] {DateTime.Now:yyyy-MM-dd HH:mm:ss} - {ex}\n\n");
        }
        catch (Exception logEx)
        {
            Console.WriteLine($"Ошибка записи ошибки в лог: {logEx.Message}");
        }
    }
}