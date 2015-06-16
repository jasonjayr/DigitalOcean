use strict;
package DigitalOcean::Droplet;
use Mouse;
use DigitalOcean::Types;
use DigitalOcean::Snapshot;

#ABSTRACT: Represents a Droplet object in the DigitalOcean API

has DigitalOcean => ( 
    is => 'rw',
    isa => 'DigitalOcean',
);

has id => ( 
    is => 'ro',
    isa => 'Num',
);

has name => (
    is => 'rw',
    isa => 'Str',
);

has memory => ( 
    is => 'rw',
    isa => 'Num',
);

has vcpus => ( 
    is => 'rw',
    isa => 'Num',
);

has disk => ( 
    is => 'rw',
    isa => 'Num',
);

has locked => ( 
    is => 'rw',
    isa => 'Bool',
);

has created_at => ( 
    is => 'rw',
    isa => 'Str',
);

has status => ( 
    is => 'rw',
    isa => 'Str',
);

has backup_ids => ( 
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [] },
);

has snapshot_ids => ( 
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [] },
);

has features => ( 
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [] },
);

has region => ( 
    is => 'rw',
    isa => 'Coerced::DigitalOcean::Region',
    coerce => 1,
);

has image => ( 
    is => 'rw',
    isa => 'Coerced::DigitalOcean::Image',
    coerce => 1,
);

has size => ( 
    is => 'rw',
    isa => 'Coerced::DigitalOcean::Size',
    coerce => 1,
);

has size_slug => ( 
    is => 'rw',
    isa => 'Str',
);

has networks => ( 
    is => 'rw',
    isa => 'Coerced::DigitalOcean::Networks',
    coerce => 1,
);

has kernel => ( 
    is => 'rw',
    isa => 'Undef|Coerced::DigitalOcean::Kernel',
    coerce => 1,
);

has next_backup_window => ( 
    is => 'rw',
    isa => 'Undef|Coerced::DigitalOcean::NextBackupWindow',
    coerce => 1,
);

sub _action { 
    my $self = shift;
    my (%req_body_hash) = @_;

    my %new_args;
    $new_args{path} = $self->path . 'actions';
    $new_args{req_body_hash} = \%req_body_hash;

    $self->DigitalOcean->_action(%new_args);
}

=method path

Returns the api path for this droplet.

=cut

sub path { 
    'droplets/' . shift->id . '/';
}

=method kernels
 
This will retrieve a list of all kernels available to a Dropet
by returning a L<DigitalOcean::Collection> that can be used to iterate through the L<DigitalOcean::Kernels> objects of the kernels collection. 
 
    my $kernels_collection = $droplet->kernels;
    my $obj;

    while($obj = $kernels_collection->next) { 
        print $obj->name . "\n";
    }

If you would like a different C<per_page> value to be used for this collection instead of L<per_page|DigitalOcean/"per_page">, it can be passed in as a parameter:

    #set default for all collections to be 30
    $do->per_page(30);

    #set this collection to have 2 objects returned per page
    my $kernels_collection = $droplet->kernels(2);
    my $obj;

    while($obj = $kernels_collection->next) { 
        print $obj->name . "\n";
    }
 
=cut

sub kernels { 
    my ($self, $per_page) = @_;
    return $self->DigitalOcean->_get_collection($self->path . 'kernels', 'DigitalOcean::Kernel', 'kernels', $per_page);
}

=method snapshots
 
This will retrieve the snapshots that have been created from a Droplet
by returning a L<DigitalOcean::Collection> that can be used to iterate through the L<DigitalOcean::Snapshot> objects of the snapshots collection. 
 
    my $snapshots_collection = $droplet->snapshots;
    my $obj;

    while($obj = $snapshots_collection->next) { 
        print $obj->name . "\n";
    }

If you would like a different C<per_page> value to be used for this collection instead of L<per_page|DigitalOcean/"per_page">, it can be passed in as a parameter:

    #set default for all collections to be 30
    $do->per_page(30);

    #set this collection to have 2 objects returned per page
    my $snapshots_collection = $droplet->snapshots(2);
    my $obj;

    while($obj = $snapshots_collection->next) { 
        print $obj->name . "\n";
    }
 
=cut

sub snapshots { 
    my ($self, $per_page) = @_;
    return $self->DigitalOcean->_get_collection($self->path . 'snapshots', 'DigitalOcean::Snapshot', 'snapshots', $per_page);
}

=method backups
 
This will retrieve the backups that have been created from a Droplet
by returning a L<DigitalOcean::Collection> that can be used to iterate through the L<DigitalOcean::Backup> objects of the backups collection. 
 
    my $backups_collection = $droplet->backups;
    my $obj;

    while($obj = $backups_collection->next) { 
        print $obj->name . "\n";
    }

If you would like a different C<per_page> value to be used for this collection instead of L<per_page|DigitalOcean/"per_page">, it can be passed in as a parameter:

    #set default for all collections to be 30
    $do->per_page(30);

    #set this collection to have 2 objects returned per page
    my $backups_collection = $droplet->backups(2);
    my $obj;

    while($obj = $backups_collection->next) { 
        print $obj->name . "\n";
    }
 
=cut

sub backups { 
    my ($self, $per_page) = @_;
    return $self->DigitalOcean->_get_collection($self->path . 'backups', 'DigitalOcean::Backup', 'backups', $per_page);
}

=method actions
 
This will retrieve all actions that have been executed on a Droplet
by returning a L<DigitalOcean::Collection> that can be used to iterate through the L<DigitalOcean::Action> objects of the actions collection. 
 
    my $actions_collection = $droplet->actions;
    my $obj;

    while($obj = $actions_collection->next) { 
        print $obj->id . "\n";
    }

If you would like a different C<per_page> value to be used for this collection instead of L<per_page|DigitalOcean/"per_page">, it can be passed in as a parameter:

    #set default for all collections to be 30
    $do->per_page(30);

    #set this collection to have 2 objects returned per page
    my $actions_collection = $droplet->actions(2);
    my $obj;

    while($obj = $actions_collection->next) { 
        print $obj->id . "\n";
    }
 
=cut

sub actions { 
    my ($self, $per_page) = @_;
    my $init_arr = [['DigitalOcean', $self]];
    return $self->DigitalOcean->_get_collection($self->path . 'actions', 'DigitalOcean::Action', 'actions', $per_page, $init_arr);
}

=method delete

This deletes the droplet. This will return 1 on success and undef on failure.

    $droplet->delete;
    #droplet now gone

=cut

sub delete { 
    my ($self) = @_;
    return $self->DigitalOcean->_delete(path => $self->path);
}

=method neighbors

This method returns all of the droplets that are running on the same physical server as the L<DigitalOcean::Droplet> object this method is called with.
It returns an array reference.

    my $neighbors = $droplet->neighbors;

    for my $neighbor (@$neighbors) { 
        print $neighbor->name . "\n";
    }

=cut

sub neighbors { 
    my ($self) = @_;

    return $self->DigitalOcean->_get_array($self->path . 'neighbors', 'DigitalOcean::Droplet', 'droplets');

}

=head2 Actions

=method disable_backups

This method disables backups on your droplet. It returns a L<DigitalOcean::Action> object.

    my $action = $droplet->disable_backups;

=cut

sub disable_backups { shift->_action(@_, type => 'disable_backups') }

=method reboot

This method allows you to reboot a droplet. This is the preferred method to use if a server is not responding. It returns a L<DigitalOcean::Action> object.

    my $action = $droplet->reboot;

A reboot action is an attempt to reboot the Droplet in a graceful way, similar to using the reboot command from the console.

=cut

sub reboot { shift->_action(@_, type => 'reboot') }

=method power_cycle

This method allows you to power cycle a droplet. This will turn off the droplet and then turn it back on. It returns a L<DigitalOcean::Action> object.

    my $action = $droplet->power_cycle;

A powercycle action is similar to pushing the reset button on a physical machine, it's similar to booting from scratch.

=cut

sub power_cycle { shift->_action(@_, type => 'power_cycle') }

=method shutdown

This method allows you to shutdown a running droplet. The droplet will remain in your account. It returns a L<DigitalOcean::Action> object.

    my $action = $droplet->shutdown;

A shutdown action is an attempt to shutdown the Droplet in a graceful way, similar to using the shutdown command from the console. Since a shutdown command can fail, this action guarantees that the command is issued, not that it succeeds. The preferred way to turn off a Droplet is to attempt a shutdown, with a reasonable timeout, followed by a power off action to ensure the Droplet is off.

=cut

sub shutdown { shift->_action(@_, type => 'shutdown') }

=method power_off

This method allows you to poweroff a running droplet. The droplet will remain in your account. It returns a L<DigitalOcean::Action> object.

    my $action = $droplet->power_off;

A power_off event is a hard shutdown and should only be used if the shutdown action is not successful. It is similar to cutting the power on a server and could lead to complications.

=cut

sub power_off { shift->_action(@_, type => 'power_off') }

=method power_on

This method allows you to poweron a powered off droplet. It returns a L<DigitalOcean::Action> object.

    my $action = $droplet->power_on;

=cut

sub power_on { shift->_action(@_, type => 'power_on') }

=method restore
 
This method allows you to restore a droplet with a previous image or snapshot. This will be a mirror copy of the image or snapshot to your droplet. Be sure you have backed up any necessary information prior to restore.
It returns a L<DigitalOcean::Action> object.
 
=over 4
 
=item
 
B<image> Required, string if an image slug. number if an image ID., An image slug or ID. This represents the image that the Droplet will use as a base.
 
=back
 
    my $action = $droplet->restore(image => 56789);

A Droplet restoration will rebuild an image using a backup image. The image ID that is passed in must be a backup of the current Droplet instance. The operation will leave any embedded SSH keys intact.

=cut

sub restore { shift->_action(@_, type => 'restore') }

=method password_reset

This method will reset the root password for a droplet. Please be aware that this will reboot the droplet to allow resetting the password. It returns a L<DigitalOcean::Action> object.

    my $action = $droplet->password_reset;

=cut

sub password_reset { shift->_action(@_, type => 'password_reset') }

=method resize

This method allows you to resize a specific droplet to a different size. It returns a L<DigitalOcean::Action> object.

=over 4
 
=item
 
B<disk> Optional, Boolean (1 or undef), Whether to increase disk size

=item
 
B<size> Required, String, The size slug that you want to resize to.
 
=back

    my $action = $droplet->resize(
        disk => 1,
        size => '1gb', 
    );

In order to resize your droplet, it must first be powered off, and you must wait for the droplet
to be powered off before you can call resize on the droplet. Making the call accurately would look something like this:
 
    $droplet->power_off(wait_on_action => 1);

    my $action = $droplet->resize(
        disk => 1,
        size => '1gb', 
        wait_on_action => 1,
    );

    $droplet->power_on(wait_on_action => 1);
             
If your droplet is already on and you want to resize it and boot your droplet
back up, you can call L</resize_reboot> to do the above code for you.

=cut

sub resize { shift->_action(@_, type => 'resize') }

=method resize_reboot
 
If your droplet is already running, this method makes a call to L<resize|/"resize">
for you and powers off your droplet, and then powers it on after it is done resizing
and handles L<waiting on each event|DigitalOcean/"WAITING ON EVENTS"> to finish so you do not have to write this code.
This is essentially the code that L</resize_reboot> performs for you:
 
    $droplet->power_off(wait_on_action => 1);

    $droplet->resize(
        disk => $disk,
        size => $size,
        wait_on_action => 1,
    );

    $droplet->power_on(wait_on_event => 1);

So a call to L</resize_reboot> would look like:

    my $actions = $droplet->resize_reboot(
        disk => 1,
        size => '1gb', 
    );

    for my $action (@$actions) { 
        print $action->id . ' ' . $action->status . "\n";
    }

It returns an array reference of all three actions returned by L</power_off>, L</resize>, and L</power_on>.
 
=cut
 
sub resize_reboot { 
    my $self = shift;
    my @arr;

    push(@arr, $self->power_off(wait_on_action => 1));
    push(@arr, $self->resize(@_, wait_on_action => 1));
    push(@arr, $self->power_on(wait_on_action => 1));

    return \@arr;
}

=method rebuild

This method allows you to rebuild a Droplet. It returns a L<DigitalOcean::Action> object.
A rebuild action functions just like a new create.

=over 4
 
=item
 
B<image> Required, string if an image slug. number if an image ID., An image slug or ID. This represents the image that the Droplet will use as a base.
 
=back

    my $action = $droplet->rebuild(
        image => 'ubuntu-14-04-x64',
    );

=cut

sub rebuild { shift->_action(@_, type => 'rebuild') }

=head1 SYNOPSIS
 
    FILL ME IN   

=head1 DESCRIPTION
 
FILL ME IN
 
=method id
=cut

__PACKAGE__->meta->make_immutable();

1;
