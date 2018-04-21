module derelict.discord.rpc.types;

alias int64_t = long;
alias int8_t = byte;

/+ discord_rpc.h +/

/++
    See_Also:
        https://discordapp.com/developers/docs/rich-presence/how-to#updating-presence-update-presence-payload-fields
 +/
struct DiscordRichPresence
{
    /++
        max 128 bytes
     +/
    const(char)* state;

    /++
        max 128 bytes
     +/
    const(char)* details;

    /++ +/
    int64_t startTimestamp;

    /++ +/
    int64_t endTimestamp;

    /++
        max 32 bytes
     +/
    const(char)* largeImageKey;

    /++
        max 128 bytes
     +/
    const(char)* largeImageText;
    /++
        max 32 bytes
     +/

    const(char)* smallImageKey;
    /++
        max 128 bytes
     +/
    const(char)* smallImageText;

    /++
        max 128 bytes
     +/
    const(char)* partyId;

    /++ +/
    int partySize;

    /++ +/
    int partyMax;

    /++
        max 128 bytes
     +/
    const(char)* matchSecret;

    /++
        max 128 bytes
     +/
    const(char)* joinSecret;

    /++
        max 128 bytes
     +/
    const(char)* spectateSecret;

    /++ +/
    int8_t instance;
}

/++
    See_Also:
        https://discordapp.com/developers/docs/rich-presence/how-to#ask-to-join-ask-to-join-payload-fields
 +/
struct DiscordJoinRequest
{
    /++ +/
    const(char)* userId;

    /++ +/
    const(char)* username;

    /++ +/
    const(char)* discriminator;

    /++ +/
    const(char)* avatar;
}

alias ReadyCallback = extern (C) void function();
alias DisconnectedCallback = extern (C) void function(int errorCode, const(char)* message);
alias ErroredCallback = extern (C) void function(int errorCode, const(char)* message);
alias JoinGameCallback = extern (C) void function(const(char)* joinSecret);
alias SpectateGameCallback = extern (C) void function(const(char)* spectateSecret);
alias JoinRequestCallback = extern (C) void function(const(DiscordJoinRequest)* request);

/++ +/
struct DiscordEventHandlers
{
    /++ +/
    ReadyCallback ready;

    /++ +/
    DisconnectedCallback disconnected;

    /++ +/
    ErroredCallback errored;

    /++ +/
    JoinGameCallback joinGame;

    /++ +/
    SpectateGameCallback spectateGame;

    /++ +/
    JoinRequestCallback joinRequest;
}

/++
    See_Also:
        https://discordapp.com/developers/docs/rich-presence/how-to#ask-to-join-ask-to-join-response-codes
 +/
enum : int
{
    /++ +/
    DISCORD_REPLY_NO = 0,

    /++ +/
    DISCORD_REPLY_YES = 1,

    /++ +/
    DISCORD_REPLY_IGNORE = 2
}
