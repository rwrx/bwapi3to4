use strict;
use warnings;

use File::Find; 

find(sub {
  if (-f and (/\.cpp$/ || /\.hpp$/ || /\.h$/)) {
    my $filename = $_;
    
    print "processing " . $File::Find::name . " ...\n";
    
    my $data = read_file($filename);

    $data =~ s/Unit[ ]*\*/Unit/g;
    $data =~ s/UnitTypes::getType/UnitType::getType/g;
    $data =~ s/isWalkable/isAccessible/g;
    $data =~ s/\.x()/\.x/g;
    $data =~ s/\.y()/\.y/g;
    $data =~ s/groundWeaponMaxRange/weaponMaxRange/g;
    $data =~ s/airWeaponMaxRange/weaponMaxRange/g;
    $data =~ s/groundWeaponDamageCooldown/weaponDamageCooldown/g;
    $data =~ s/energyUsed/energyCost/g;
    $data =~ s/BulletTypes::getBulletType/BulletType::getType/g;
    $data =~ s/Colors::getColor/Color::getType/g;
    $data =~ s/DamageTypes::getDamageType/DamageType::getType/g;
    $data =~ s/Errors::getError/Error::getType/g;
    $data =~ s/ExplosionTypes::getExplosionType/ExplosionType::getType/g;
    $data =~ s/GameTypes::getGameType/GameType::getType/g;
    $data =~ s/Orders::getOrder/Order::getType/g;
    $data =~ s/PlayerTypes::getPlayerType/PlayerType::getType/g;
    $data =~ s/Races::getUnit/Race::getType/g;
    $data =~ s/TechTypes::getTechType/TechType::getType/g;
    $data =~ s/UnitTypes::getUnit/UnitType::getType/g;
    $data =~ s/UnitCommandTypes::getUnitCommandType/UnitCommandType::getType/g;
    $data =~ s/UnitSizeTypes::getUnitSizeType/UnitSizeType::getType/g;
    $data =~ s/UnitType::getUnitType/UnitType::getType/g;
    $data =~ s/UpgradeType::getUpgradeType/UpgradeType::getType/g;
    $data =~ s/WeaponType::getWeaponType/WeaponType::getType/g;
    
    #if ($data =~ m/getUpgradeLevel/g) { 
    #  print "Found '$&'.  Next attempt at character " . pos($data)+1 . "\n"; 
    #}

    write_file($filename, $data);
  }
}, '.');

sub read_file {
    my ($filename) = @_;
 
    open my $in, '<:encoding(UTF-8)', $filename or die "Could not open '$filename' for reading $!";
    local $/ = undef;
    my $all = <$in>;
    close $in;
 
    return $all;
}
 
sub write_file {
    my ($filename, $content) = @_;
 
    open my $out, '>:encoding(UTF-8)', $filename or die "Could not open '$filename' for writing $!";;
    print $out $content;
    close $out;
 
    return;
}