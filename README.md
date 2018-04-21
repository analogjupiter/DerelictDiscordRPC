# DerelictDiscordRPC

A dynamic binding to the *Discord Rich Presence (Discord-RPC)* library.

This is *not* an official Derelict binding.

## Installation

You'll need a copy of the *Discord-RPC* dynamic library.
Either [download the SDK](https://github.com/discordapp/discord-rpc) and build it yourself
or download the pre-compiled binaries from [their GitHub releases page](https://github.com/discordapp/discord-rpc/releases).
Please note that the SDK is licensed under the terms of the [MIT license](Discord-RPC_LICENSE).

In order to use this bindings, add this package [as dependency](https://code.dlang.org/getting_started#adding-deps)
to your DUB project.


## Usage

```D

void main()
{
    // Load the Discord-RPC library.
    DerelictDiscordRPC.load();

    // Now Discord-RPC can be called.
    ... 
}
```

For further information check the
[Discord-RPC](https://discordapp.com/developers/docs/rich-presence/how-to) docs.


## Acknowledgement

**Thanks to...**

 - [DerelictOrg](https://github.com/DerelictOrg) and [Mike "aldacron" Parker](https://github.com/mdparker) for the [DerelictUtil](https://github.com/DerelictOrg/DerelictUtil).
 - [Guillaume "p0nce" Piolat](https://www.auburnsounds.com/) for his easy to understand *Un4seen BASS* [bindings](https://github.com/p0nce/DerelictBASS).
 - [Jan "WebFreak" Jurzitza](https://twitter.com/webfreak001) for his help with translating some callbacks and for his great VS Code plugin for the D Programming Language [code-d](https://marketplace.visualstudio.com/items?itemName=webfreak.code-d). Don't forget to check out his Discord client library [discord-w](https://github.com/WebFreak001/discord-w)!
 - [Discord, Inc.](https://discordapp.com/) for their great chat client.
