#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

#minimum needed
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

#temporary
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["OnCallLookupApi.csproj", "."]
RUN dotnet restore "./OnCallLookupApi.csproj"  #to build those dependencies / packages
COPY . .
WORKDIR "/src/."
RUN dotnet build "OnCallLookupApi.csproj" -c Release -o /app/build

#temporary
FROM build AS publish
RUN dotnet publish "OnCallLookupApi.csproj" -c Release -o /app/publish

# add to base 
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "OnCallLookupApi.dll"]