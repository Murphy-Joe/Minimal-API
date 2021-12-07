var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapGet("/", async () =>
{
    await Task.Delay(3000);
    return new OnCallDeveloperResponse
    {
        OnCallDeveloperEmail = "sue@aol.com",
        OnCallDeveloperName = "Sioxsie Sue"
    };
});

app.Run();
public class OnCallDeveloperResponse
{
    public string OnCallDeveloperName { get; set; } = String.Empty;
    public string OnCallDeveloperEmail { get; set; } = String.Empty;
}
