import { GuildMember, MessageEmbed } from 'discord.js';

export function memberEmbed(member: GuildMember) {
  return new MessageEmbed().setColor(member.roles.highest.color);
}