Name:           getchoo-container-policy
Version:        0.1
Release:        %autorelease
Summary:        getchoo's container signing policy
License:        MIT
URL:            https://github.com/getchoo/fedora-oci-images
BuildArch:      noarch

Source0:        container-policy.tar.gz

%description
getchoo's container policy for verifying images from ghcr.io/getchoo

%prep
%autosetup -c -T

%install
tar -xzf %{SOURCE0} -C %{buildroot} --strip-component=1

%files
%attr(0644,root,root) %{_exec_prefix}/etc/containers/policy.json
%attr(0644,root,root) %{_exec_prefix}/etc/containers/registries.d/getchoo.yaml
%attr(0644,root,root) %{_exec_prefix}/etc/pki/containers/fulcio_v1.crt.pem
%attr(0644,root,root) %{_exec_prefix}/etc/pki/containers/rekor.pub

%changelog
%autochangelog
