import core.stdc.time : time, time_t;
import std.conv : to;
import std.datetime;
import std.stdio;
import std.string : fromStringz;

import derelict.discord.rpc;

/++
    Register your app on Discord to get your own one :)

    See_Also:
        https://discordapp.com/developers/applications/me
 +/
enum AppID = "437408161591459840";

void main()
{
    DerelictDiscordRPC.load();

    DiscordEventHandlers handlers;
    handlers.ready = &handleReady;
    handlers.disconnected = &handleDisconnected;
    handlers.errored = &handleError;
    handlers.joinGame = &handleJoinGame;
    handlers.spectateGame = &handleSpectateGame;
    handlers.joinRequest = &handleJoinRequest;

    Discord_Initialize(AppID, &handlers, 1, null);

    int start = time(null);

    for (;;)
    {
        readln();
        update(start);
    }
}

private:

DiscordRichPresence rpc;

void update(int start)
{
    rpc.state = "Trying out DerelictDiscordRPC";
    rpc.details = "A dynamic binding to the 🎮 Discord Rich Presence (Discord-RPC) library.";
    rpc.startTimestamp = start;
    rpc.largeImageKey = "voidblaster-large";
    rpc.smallImageKey = "voidblaster-small";
    rpc.instance = 0;
    Discord_UpdatePresence(&rpc);
}

extern (C) void handleReady()
{
    writeln("Discord-RPC is ready.");
}

extern (C) void handleDisconnected(int errorCode, const(char)* message)
{
    writeln(
            "Discord-RPC disconnected because of error " ~ errorCode.to!string
            ~ ": " ~ message.fromStringz);
}

extern (C) void handleError(int errorCode, const(char)* message)
{
    writeln("An Discord-RPC error occured (" ~ errorCode.to!string ~ "): " ~ message.fromStringz);
}

extern (C) void handleJoinGame(const(char)* joinSecret)
{
    writeln("Someone wants to join the game; secret: " ~ joinSecret.fromStringz);
}

extern (C) void handleSpectateGame(const(char)* spectateSecret)
{
    writeln("Someone wants to spectate; secret: " ~ spectateSecret.fromStringz);
}

extern (C) void handleJoinRequest(const(DiscordJoinRequest)* request)
{
    writeln("Received a join request from " ~ request.username.fromStringz
            ~ " (ID: " ~ request.userId.to!string ~ ")");
}
