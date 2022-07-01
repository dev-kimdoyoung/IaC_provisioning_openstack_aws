import unittest
import testinfra


class Test(unittest.TestCase):

    def setUp(self):
        self.host = testinfra.get_host("local://", sudo=True)


    def tearDown(self) -> None:
        return super().tearDown()


    def test_exist_account_group(self):
        bastion_user = self.host.user("bastion")
        wheel = self.host.group("wheel")
        
        self.assertTrue(wheel.exists)
        self.assertTrue(bastion_user.exists)


    # def test_systemd_services(host):
    #     assert host.package('ntpd').is_installed == True
    #     ntp = host.service('ntp')
    #     assert ntp.is_running == True
    #     assert ntp.is_enabled == True


if __name__ == "__main__":
    unittest.main()

