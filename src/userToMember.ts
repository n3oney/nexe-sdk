import { Client, Snowflake, User } from 'discord.js';

export async function userToMember(
  client: Client,
  user: User,
  guildId: Snowflake
) {
  const guild = await client.guilds.fetch(guildId);
  return guild.members.fetch(user.id);
}
