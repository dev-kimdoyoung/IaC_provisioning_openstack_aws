import unittest

from sklearn.feature_selection import SelectKBest
import testinfra
   
# def test_systemd_services(host):
#     assert host.package('ntpd').is_installed == True
#     ntp = host.service('ntp')
#     assert ntp.is_running == True
#     assert ntp.is_enabled == True


# def test_network(host):
#     en0_interface = host.interface("en0")
#     assert en0_interface.exists 



class Test(unittest.TestCase):

    def setUp(self):
        self.host = testinfra.get_host("local://", sudo=True)
        # self.host = testinfra.get_host("paramiko://localhost")
        # self.host = testinfra.get_host("paramiko://bastion:admin@3.35.172.16:22")


    def tearDown(self) -> None:
        return super().tearDown()


    def test_exist_account_group(self):
        bastion_user = self.host.user("bastion")
        wheel = self.host.group("wheel")
        bastion = self.host.group("bastion")
        
        self.assertTrue(wheel.exists)
        self.assertTrue(bastion.exists)
        self.assertTrue(bastion_user.exists)


    # def test_enable_and_running_system_daemon(self):
    #     chrony = self.host.service("chronyd")
    #     self.assertTrue(chrony.is_running)
    #     self.assertTrue(chrony.is_enabled)


if __name__ == "__main__":
    unittest.main()

