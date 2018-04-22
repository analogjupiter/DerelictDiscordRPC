import core.stdc.stdint;
import core.stdc.stdio;
import core.stdc.string;
import core.stdc.time;

import derelict.discord.rpc;

/+
    This example has been ported to non-idiomatic D.
    Source: https://github.com/discordapp/discord-rpc/blob/master/examples/send-presence/send-presence.c
 +/

/*
    This is a simple example in C of using the rich presence API asynchronously.
*/

static const char* APPLICATION_ID = "345229890980937739";
static int FrustrationLevel = 0;
static int64_t StartTime;
static int SendPresence = 1;

static int prompt(char* line, size_t size)
{
    int res;
    char* nl;
    printf("\n> ");
    fflush(stdout);
    res = fgets(line, cast(int) size, stdin) ? 1 : 0;
    line[size - 1] = 0;
    nl = strchr(line, '\n');
    if (nl)
    {
        *nl = 0;
    }
    return res;
}

static void updateDiscordPresence()
{
    if (SendPresence)
    {
        char[256] buffer;
        DiscordRichPresence discordPresence;
        discordPresence.state = "West of House";
        sprintf(buffer.ptr, "Frustration level: %d", FrustrationLevel);
        discordPresence.details = buffer.ptr;
        discordPresence.startTimestamp = StartTime;
        discordPresence.endTimestamp = time(null) + 5 * 60;
        discordPresence.largeImageKey = "canary-large";
        discordPresence.smallImageKey = "ptb-small";
        discordPresence.partyId = "party1234";
        discordPresence.partySize = 1;
        discordPresence.partyMax = 6;
        discordPresence.matchSecret = "xyzzy";
        discordPresence.joinSecret = "join";
        discordPresence.spectateSecret = "look";
        discordPresence.instance = 0;
        Discord_UpdatePresence(&discordPresence);
    }
    else
    {
        Discord_ClearPresence();
    }
}

extern (C) static void handleDiscordReady()
{
    printf("\nDiscord: ready\n");
}

extern (C) static void handleDiscordDisconnected(int errcode, const char* message)
{
    printf("\nDiscord: disconnected (%d: %s)\n", errcode, message);
}

extern (C) static void handleDiscordError(int errcode, const char* message)
{
    printf("\nDiscord: error (%d: %s)\n", errcode, message);
}

extern (C) static void handleDiscordJoin(const char* secret)
{
    printf("\nDiscord: join (%s)\n", secret);
}

extern (C) static void handleDiscordSpectate(const char* secret)
{
    printf("\nDiscord: spectate (%s)\n", secret);
}

extern (C) static void handleDiscordJoinRequest(const DiscordJoinRequest* request)
{
    int response = -1;
    char[4] yn;
    printf("\nDiscord: join request from %s - %s - %s\n", request.username,
            request.avatar, request.userId);
    do
    {
        printf("Accept? (y/n)");
        if (!prompt(yn.ptr, yn.length))
        {
            break;
        }

        if (!yn[0])
        {
            continue;
        }

        if (yn[0] == 'y')
        {
            response = DISCORD_REPLY_YES;
            break;
        }

        if (yn[0] == 'n')
        {
            response = DISCORD_REPLY_NO;
            break;
        }
    }
    while (1);
    if (response != -1)
    {
        Discord_Respond(request.userId, response);
    }
}

static void discordInit()
{
    DiscordEventHandlers handlers;
    handlers.ready = &handleDiscordReady;
    handlers.disconnected = &handleDiscordDisconnected;
    handlers.errored = &handleDiscordError;
    handlers.joinGame = &handleDiscordJoin;
    handlers.spectateGame = &handleDiscordSpectate;
    handlers.joinRequest = &handleDiscordJoinRequest;
    Discord_Initialize(APPLICATION_ID, &handlers, 1, null);
}

static void gameLoop()
{
    char[512] line;
    char* space;

    StartTime = time(null);

    printf("You are standing in an open field west of a white house.\n");
    while (prompt(line.ptr, line.length))
    {
        if (line[0])
        {
            if (line[0] == 'q')
            {
                break;
            }

            if (line[0] == 't')
            {
                printf("Shutting off Discord.\n");
                Discord_Shutdown();
                continue;
            }

            if (line[0] == 'c')
            {
                if (SendPresence)
                {
                    printf("Clearing presence information.\n");
                    SendPresence = 0;
                }
                else
                {
                    printf("Restoring presence information.\n");
                    SendPresence = 1;
                }
                updateDiscordPresence();
                continue;
            }

            if (line[0] == 'y')
            {
                printf("Reinit Discord.\n");
                discordInit();
                continue;
            }

            if (time(null) & 1)
            {
                printf("I don't understand that.\n");
            }
            else
            {
                space = strchr(line.ptr, ' ');
                if (space)
                {
                    *space = 0;
                }
                printf("I don't know the word \"%s\".\n", line.ptr);
            }

            ++FrustrationLevel;

            updateDiscordPresence();
        }
    }
}

int main()
{
    DerelictDiscordRPC.load();

    discordInit();

    gameLoop();

    Discord_Shutdown();
    return 0;
}
