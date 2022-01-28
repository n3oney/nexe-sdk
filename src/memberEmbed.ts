import { GuildMember, MessageEmbed } from 'discord.js';

export function memberEmbed(member: GuildMember, setAuthor = true) {
  const embed = new MessageEmbed()
    .setColor(member.roles.highest.color);
  if (setAuthor) {
    embed.setAuthor({
      iconURL: member.displayAvatarURL({
        dynamic: true,
        size: 128
      }),
      name: member.displayName
    });
  }

  return embed;
}