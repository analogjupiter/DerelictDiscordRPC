module derelict.discord.rpc;

import derelict.util.loader;
import derelict.util.system;

public
{
    import derelict.discord.rpc.functions;
    import derelict.discord.rpc.types;
}

private
{
    static if (Derelict_OS_Windows)
    {
        enum libNames = "discord-rpc.dll";
    }
    else static if (Derelict_OS_Linux)
    {
        enum libNames = "libdiscord-rpc.so";
    }
    else static if (Derelict_OS_Mac)
    {
        enum libNames = "libdiscord-rpc.dylib";
    }
    else
    {
        static assert(0,
                "Sorry, no Discord-RPC libNames implemented for this OS.\nFeel free to submit a PR on GitHub :) ");
    }
}

/++
    Derelict loader for Discord-RPC
 +/
class DerelictDiscordRPCLoader : SharedLibLoader
{

    /++
        ctor
     +/
    public this()
    {
        super(libNames);
    }

    protected override void loadSymbols()
    {
        bindFunc(cast(void**)(&Discord_Register), "Discord_Register");
        bindFunc(cast(void**)(&Discord_RegisterSteamGame), "Discord_RegisterSteamGame");
        bindFunc(cast(void**)(&Discord_Initialize), "Discord_Initialize");
        bindFunc(cast(void**)(&Discord_Shutdown), "Discord_Shutdown");
        bindFunc(cast(void**)(&Discord_RunCallbacks), "Discord_RunCallbacks");
        version (DISCORD_DISABLE_IO_THREAD)
        {
            bindFunc(cast(void**)(&Discord_UpdateConnection), "Discord_UpdateConnection");
        }
        bindFunc(cast(void**)(&Discord_UpdatePresence), "Discord_UpdatePresence");
        bindFunc(cast(void**)(&Discord_ClearPresence), "Discord_ClearPresence");
        bindFunc(cast(void**)(&Discord_Respond), "Discord_Respond");
        bindFunc(cast(void**)(&Discord_UpdateHandlers), "Discord_UpdateHandlers");
    }
}

/++
    A __gshared instance of DerelictDiscordRPCLoader
 +/
__gshared DerelictDiscordRPCLoader DerelictDiscordRPC = new DerelictDiscordRPCLoader();
