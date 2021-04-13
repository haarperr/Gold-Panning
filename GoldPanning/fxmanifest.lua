games {'gta5'}

fx_version 'bodacious'

description 'Gold panning'
version '1.0.0'

dependencies {'PolyZone'} 

client_scripts {
  '@PolyZone/client.lua',
  'config.lua',
  'client/cl_*.lua'
}

server_scripts {
  'config.lua',
  'server/sv_*.lua'
}
