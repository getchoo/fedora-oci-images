Name:           getchoo-akmods-cert
Version:        0.1
Release:        %autorelease
Summary:        getchoo's public certificate for signed akmods
License:        MIT
URL:            https://github.com/getchoo/fedora-oci-images
BuildArch:      noarch
Supplements:    mokutil policycoreutils

Source0:        public_key.der

%description
getchoo's public certificate for enabling secure boot with applicable signed akmods

%prep
%autosetup -c -T

%install
install -Dm644 %{SOURCE0} %{buildroot}%{_sysconfdir}/pki/akmods/certs/akmods-getchoo.der

%files
%attr(0644,root,root) %{_sysconfdir}/pki/akmods/certs/akmods-getchoo.der

%changelog
%autochangelog
