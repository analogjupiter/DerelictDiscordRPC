module derelict.discord.rpc.functions;

import derelict.util.loader;
import derelict.util.system;
import derelict.discord.rpc.types;

/+ discord_register.h +/
extern (C) @nogc nothrow
{
    alias da_Discord_Register = void function(const(char)* applicationId, const(char)* command);
    alias da_Discord_RegisterSteamGame = void function(const(char)* applicationId,
            const(char)* command);
}

/+ discord_rpc.h +/
extern (C) @nogc nothrow
{
    alias da_Discord_Initialize = void function(const(char)* applicationId,
            DiscordEventHandlers* handlers, int autoRegister, const(char)* optionalSteamId);
    alias da_Discord_Shutdown = void function();
    alias da_Discord_RunCallbacks = void function();
    version (DISCORD_DISABLE_IO_THREAD)
    {
        alias da_Discord_UpdateConnection = void function();
    }
    alias da_Discord_UpdatePresence = void function(const DiscordRichPresence* presence);
    alias da_Discord_ClearPresence = void function();
    alias da_Discord_Respond = void function(const(char)* userid, DISCORD_REPLY_ reply);
    alias da_Discord_UpdateHandlers = void function(DiscordEventHandlers* handlers);
}

/+ discord_register.h +/
__gshared
{
    /++ +/
    da_Discord_Register Discord_Register;

    /++ +/
    da_Discord_RegisterSteamGame Discord_RegisterSteamGame;
}

__gshared
{

    /++
        See_Also:
            https://discordapp.com/developers/docs/rich-presence/how-to#initialization
     +/
    da_Discord_Initialize Discord_Initialize;

    /++
        See_Also:
            https://discordapp.com/developers/docs/rich-presence/how-to#initialization
     +/
    da_Discord_Shutdown Discord_Shutdown;

    /++
        checks for incoming messages, dispatches callbacks
     +/
    da_Discord_RunCallbacks Discord_RunCallbacks;

    version (DISCORD_DISABLE_IO_THREAD)
    {
        /++
            If you disable the lib starting its own io thread, you'll need to call this from your own
         +/
        da_Discord_UpdateConnection Discord_UpdateConnection;
    }

    /++
        See_Also:
            https://discordapp.com/developers/docs/rich-presence/how-to#updating-presence
     +/
    da_Discord_UpdatePresence Discord_UpdatePresence;

    /++ +/
    da_Discord_ClearPresence Discord_ClearPresence;

    /++
        See_Also:
            https://discordapp.com/developers/docs/rich-presence/how-to#ask-to-join
     +/
    da_Discord_Respond Discord_Respond;

    /++ +/
    da_Discord_UpdateHandlers Discord_UpdateHandlers;

}
