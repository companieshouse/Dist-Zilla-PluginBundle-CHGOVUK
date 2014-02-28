use strict;
use warnings;

package Dist::Zilla::PluginBundle::CHGOVUK;
use Moose;

with 'Dist::Zilla::Role::PluginBundle::Easy';

sub configure {
    my ($self) = @_;

    $self->add_bundle('@Basic');

    $self->add_plugins([
        'Git::NextVersion' => {
            first_version  => '0.01',
            version_regexp => '^(\d+\.\d+)$'
        }
    ]);

    $self->add_plugins([
        'ReadmeAnyFromPod / ReadmePodInRoot' => {
            type     => 'markdown',
            filename => 'README.md',
            location => 'root',
        }
    ]);

    $self->add_plugins('AutoPrereqs');

    $self->add_plugins([
        'NextRelease' => {
            format => '%-v  %{yyyy-MM-dd}d'
        }
    ]);

    $self->add_plugins(qw(
        SynopsisTests
        PodSyntaxTests
        MetaJSON
    ));

    $self->add_plugins([
        'GithubMeta' => {
            issues => 1
        }
    ]);

    $self->add_plugins(qw(Git::Commit));

    $self->add_plugins([
        'Git::Tag' => {
            tag_format => '%v'
        }
    ]);

}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

=head1 NAME

Dist::Zilla::PluginBundle::CHGOVUK - Dist::Zilla plugin bundle for Companies House

=head1 DESCRIPTION

This is the plugin bundle that Companies House uses. It's equivalent to:

    [@Basic]

    [Git::NextVersion]
    first_version   = 0.01
    version_regexp  = ^(\d+\.\d+)$

    [ReadmeAnyFromPod / ReadmePodInRoot]
    type = markdown
    filename = README.md
    location = root

    [AutoPrereqs]

    [NextRelease]
    format          = %-v  %{yyyy-MM-dd}d

    [Test::Synopsis]

    [PodSyntaxTests]

    [MetaJSON]

    [GithubMeta]
    issues = 1

    [Git::Commit]

    [Git::Tag]
    tag_format      = %v

=cut

